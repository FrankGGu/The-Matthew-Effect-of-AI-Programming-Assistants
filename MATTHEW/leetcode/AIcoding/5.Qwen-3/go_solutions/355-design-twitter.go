package main

type Twitter struct {
    tweetId      int
    userTweets   map[int][]int
    followMap    map[int]map[int]bool
}

func Constructor() Twitter {
    return Twitter{
        tweetId:    0,
        userTweets: make(map[int][]int),
        followMap:  make(map[int]map[int]bool),
    }
}

func (t *Twitter) postTweet(userId int, tweetId int) {
    t.tweetId++
    t.userTweets[userId] = append(t.userTweets[userId], t.tweetId)
}

func (t *Twitter) getNewsFeed(userId int) []int {
    var result []int
    for i := len(t.userTweets[userId]) - 1; i >= 0 && len(result) < 10; i-- {
        result = append(result, t.userTweets[userId][i])
    }
    for followeeId := range t.followMap[userId] {
        for i := len(t.userTweets[followeeId]) - 1; i >= 0 && len(result) < 10; i-- {
            result = append(result, t.userTweets[followeeId][i])
        }
    }
    return result
}

func (t *Twitter) follow(followerId int, followeeId int) {
    if _, exists := t.followMap[followerId]; !exists {
        t.followMap[followerId] = make(map[int]bool)
    }
    t.followMap[followerId][followeeId] = true
}

func (t *Twitter) unfollow(followerId int, followeeId int) {
    delete(t.followMap[followerId], followeeId)
}