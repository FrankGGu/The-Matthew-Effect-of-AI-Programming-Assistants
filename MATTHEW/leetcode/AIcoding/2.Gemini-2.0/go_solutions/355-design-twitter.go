import "container/heap"

type Tweet struct {
    userID int
    tweetID int
    timestamp int
}

type User struct {
    userID int
    followed map[int]bool
    tweets []Tweet
}

type Twitter struct {
    users map[int]*User
    timestamp int
}

func Constructor() Twitter {
    return Twitter{
        users: make(map[int]*User),
        timestamp: 0,
    }
}

func (this *Twitter) PostTweet(userID int, tweetID int)  {
    if _, ok := this.users[userID]; !ok {
        this.users[userID] = &User{
            userID: userID,
            followed: make(map[int]bool),
            tweets: make([]Tweet, 0),
        }
        this.users[userID].followed[userID] = true
    }

    this.users[userID].tweets = append(this.users[userID].tweets, Tweet{userID: userID, tweetID: tweetID, timestamp: this.timestamp})
    this.timestamp++
}

func (this *Twitter) GetNewsFeed(userID int) []int {
    if _, ok := this.users[userID]; !ok {
        return []int{}
    }

    pq := &PriorityQueue{}
    heap.Init(pq)

    for id := range this.users[userID].followed {
        if user, ok := this.users[id]; ok {
            for i := len(user.tweets) - 1; i >= 0 && len(*pq) < 10; i-- {
                heap.Push(pq, &Item{tweet: user.tweets[i], priority: user.tweets[i].timestamp})
            }
        }
    }

    result := make([]int, 0)
    for pq.Len() > 0 {
        item := heap.Pop(pq).(*Item)
        result = append(result, item.tweet.tweetID)
    }

    return result
}

func (this *Twitter) Follow(followerID int, followeeID int)  {
    if _, ok := this.users[followerID]; !ok {
        this.users[followerID] = &User{
            userID: followerID,
            followed: make(map[int]bool),
            tweets: make([]Tweet, 0),
        }
        this.users[followerID].followed[followerID] = true
    }

    if _, ok := this.users[followeeID]; !ok {
        this.users[followeeID] = &User{
            userID: followeeID,
            followed: make(map[int]bool),
            tweets: make([]Tweet, 0),
        }
        this.users[followeeID].followed[followeeID] = true
    }

    this.users[followerID].followed[followeeID] = true
}

func (this *Twitter) Unfollow(followerID int, followeeID int)  {
    if _, ok := this.users[followerID]; ok && followerID != followeeID {
        delete(this.users[followerID].followed, followeeID)
    }
}

type Item struct {
    tweet Tweet
    priority int
    index int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].priority > pq[j].priority
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
    pq[i].index = i
    pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
    n := len(*pq)
    item := x.(*Item)
    item.index = n
    *pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    old[n-1] = nil  // avoid memory leak
    item.index = -1 // for safety
    *pq = old[0 : n-1]
    return item
}