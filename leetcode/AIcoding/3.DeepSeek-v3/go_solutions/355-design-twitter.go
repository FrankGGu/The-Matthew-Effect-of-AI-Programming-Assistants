type Twitter struct {
    users    map[int][]Tweet
    follows  map[int]map[int]bool
    time     int
}

type Tweet struct {
    tweetId int
    time    int
}

func Constructor() Twitter {
    return Twitter{
        users:   make(map[int][]Tweet),
        follows: make(map[int]map[int]bool),
        time:    0,
    }
}

func (this *Twitter) PostTweet(userId int, tweetId int) {
    this.users[userId] = append(this.users[userId], Tweet{tweetId, this.time})
    this.time++
}

func (this *Twitter) GetNewsFeed(userId int) []int {
    var tweets []Tweet
    if userTweets, ok := this.users[userId]; ok {
        tweets = append(tweets, userTweets...)
    }
    if followees, ok := this.follows[userId]; ok {
        for followeeId := range followees {
            if followeeTweets, ok := this.users[followeeId]; ok {
                tweets = append(tweets, followeeTweets...)
            }
        }
    }
    sort.Slice(tweets, func(i, j int) bool {
        return tweets[i].time > tweets[j].time
    })
    var res []int
    for i := 0; i < len(tweets) && i < 10; i++ {
        res = append(res, tweets[i].tweetId)
    }
    return res
}

func (this *Twitter) Follow(followerId int, followeeId int) {
    if _, ok := this.follows[followerId]; !ok {
        this.follows[followerId] = make(map[int]bool)
    }
    this.follows[followerId][followeeId] = true
}

func (this *Twitter) Unfollow(followerId int, followeeId int) {
    if followees, ok := this.follows[followerId]; ok {
        delete(followees, followeeId)
    }
}