type Twitter struct {
    tweets     map[int][]Tweet
    userFollow map[int]map[int]struct{}
    time       int
}

type Tweet struct {
    id   int
    time int
}

func Constructor() Twitter {
    return Twitter{
        tweets:     make(map[int][]Tweet),
        userFollow: make(map[int]map[int]struct{}),
        time:       0,
    }
}

func (t *Twitter) PostTweet(userId int, tweetId int) {
    t.time++
    t.tweets[userId] = append(t.tweets[userId], Tweet{id: tweetId, time: t.time})
}

func (t *Twitter) GetNewsFeed(userId int) []int {
    feed := []Tweet{}
    if _, exists := t.userFollow[userId]; exists {
        for followId := range t.userFollow[userId] {
            feed = append(feed, t.tweets[followId]...)
        }
    }
    feed = append(feed, t.tweets[userId]...)
    sort.Slice(feed, func(i, j int) bool {
        return feed[i].time > feed[j].time
    })
    result := []int{}
    for i := 0; i < min(len(feed), 10); i++ {
        result = append(result, feed[i].id)
    }
    return result
}

func (t *Twitter) Follow(followerId int, followeeId int) {
    if _, exists := t.userFollow[followerId]; !exists {
        t.userFollow[followerId] = make(map[int]struct{})
    }
    t.userFollow[followerId][followeeId] = struct{}{}
}

func (t *Twitter) Unfollow(followerId int, followeeId int) {
    if _, exists := t.userFollow[followerId]; exists {
        delete(t.userFollow[followerId], followeeId)
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}