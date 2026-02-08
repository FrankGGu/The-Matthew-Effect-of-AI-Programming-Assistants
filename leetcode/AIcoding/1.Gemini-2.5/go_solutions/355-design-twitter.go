package main

import (
	"container/heap"
)

type Tweet struct {
    tweetId int
    userId  int
    timestamp int
}

type Twitter struct {
    tweetsByUser map[int][]Tweet
    followers    map[int]map[int]bool
    timestamp    int
}

func Constructor() Twitter {
    return Twitter{
        tweetsByUser: make(map[int][]Tweet),
        followers:    make(map[int]map[int]bool),
        timestamp:    0,
    }
}

func (this *Twitter) PostTweet(userId int, tweetId int) {
    this.timestamp++
    tweet := Tweet{
        tweetId:   tweetId,
        userId:    userId,
        timestamp: this.timestamp,
    }
    this.tweetsByUser[userId] = append(this.tweetsByUser[userId], tweet)
}

func (this *Twitter) GetNewsFeed(userId int) []int {
    relevantUsers := make(map[int]bool)
    relevantUsers[userId] = true

    if followees, ok := this.followers[userId]; ok {
        for followeeID := range followees {
            relevantUsers[followeeID] = true
        }
    }

    h := &minHeap{}
    heap.Init(h)

    for uID := range relevantUsers {
        userTweets := this.tweetsByUser[uID]
        for i := len(userTweets) - 1; i >= 0; i-- {
            tweet := userTweets[i]
            if h.Len() < 10 {
                heap.Push(h, tweet)
            } else if tweet.timestamp > h.Peek().(Tweet).timestamp {
                heap.Pop(h)
                heap.Push(h, tweet)
            } else {
                break
            }
        }
    }

    newsFeed := make([]int, h.Len())
    for i := h.Len() - 1; i >= 0; i-- {
        newsFeed[i] = heap.Pop(h).(Tweet).tweetId
    }
    return newsFeed
}

func (this *Twitter) Follow(followerId int, followeeId int) {
    if _, ok := this.followers[followerId]; !ok {
        this.followers[followerId] = make(map[int]bool)
    }
    this.followers[followerId][followeeId] = true
}

func (this *Twitter) Unfollow(followerId int, followeeId int) {
    if followerId == followeeId {
        return
    }
    if followees, ok := this.followers[followerId]; ok {
        delete(followees, followeeId)
    }
}

type minHeap []Tweet

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i].timestamp < h[j].timestamp }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(Tweet))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func (h minHeap) Peek() interface{} {
    if len(h) == 0 {
        return nil
    }
    return h[0]
}