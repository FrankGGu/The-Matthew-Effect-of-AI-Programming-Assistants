package tweetCounts

import (
	"container/heap"
	"strings"
	"time"
)

type Tweet struct {
	timestamp int
}

type TweetHeap []Tweet

func (h TweetHeap) Len() int {
	return len(h)
}

func (h TweetHeap) Less(i, j int) bool {
	return h[i].timestamp < h[j].timestamp
}

func (h TweetHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *TweetHeap) Push(x interface{}) {
	*h = append(*h, x.(Tweet))
}

func (h *TweetHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type TweetCounts struct {
	tweets map[string]*TweetHeap
}

func Constructor() TweetCounts {
	return TweetCounts{tweets: make(map[string]*TweetHeap)}
}

func (this *TweetCounts) RecordTweet(tweetName string, time int) {
	if _, exists := this.tweets[tweetName]; !exists {
		this.tweets[tweetName] = &TweetHeap{}
		heap.Init(this.tweets[tweetName])
	}
	heap.Push(this.tweets[tweetName], Tweet{timestamp: time})
}

func (this *TweetCounts) GetTweetCountsPerFrequency(freq string, tweetName string, startTime int, endTime int) []int {
	var interval int

	switch freq {
	case "minute":
		interval = 60
	case "hour":
		interval = 3600
	case "day":
		interval = 86400
	}

	counts := make([]int, (endTime-startTime)/interval+1)
	if heap, exists := this.tweets[tweetName]; exists {
		for _, tweet := range *heap {
			if tweet.timestamp >= startTime && tweet.timestamp <= endTime {
				counts[(tweet.timestamp-startTime)/interval]++
			}
		}
	}
	return counts
}