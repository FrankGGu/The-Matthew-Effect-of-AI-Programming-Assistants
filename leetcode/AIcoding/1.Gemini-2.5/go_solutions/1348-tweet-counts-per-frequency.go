package main

import (
	"sort"
)

type TweetCounts struct {
	tweets map[string]*TweetData
}

type TweetData struct {
	times  []int
	sorted bool
}

func Constructor() TweetCounts {
	return TweetCounts{
		tweets: make(map[string]*TweetData),
	}
}

func (this *TweetCounts) RecordTweet(tweetName string, time int) {
	if _, ok := this.tweets[tweetName]; !ok {
		this.tweets[tweetName] = &TweetData{
			times:  make([]int, 0),
			sorted: true, // An empty slice is considered sorted
		}
	}
	this.tweets[tweetName].times = append(this.tweets[tweetName].times, time)
	this.tweets[tweetName].sorted = false // After appending, the slice might not be sorted
}

func (this *TweetCounts) GetTweetCountsPerFrequency(freq string, tweetName string, startTime int, endTime int) []int {
	tweetData, ok := this.tweets[tweetName]
	if !ok {
		return make([]int, 0)
	}

	if !tweetData.sorted {
		sort.Ints(tweetData.times)
		tweetData.sorted = true
	}
	times := tweetData.times

	var interval int
	switch freq {
	case "minute":
		interval = 60
	case "hour":
		interval = 3600
	case "day":
		interval = 86400
	}

	// Calculate the start of the first frequency bucket that overlaps with [startTime, endTime].
	// This is the bucket that contains `startTime`.
	firstBucketStart := (startTime / interval) * interval

	// Calculate the number of buckets in the result array.
	// The last bucket to consider starts at `(endTime / interval) * interval`.
	// The number of buckets is `(lastBucketStart - firstBucketStart) / interval + 1`.
	numBuckets := (endTime - firstBucketStart) / interval + 1
	if numBuckets < 0 { // Should not happen with startTime <= endTime, but for safety
		numBuckets = 0
	}
	res := make([]int, numBuckets)

	// Find the range of relevant tweets within [startTime, endTime] using binary search.
	idxLow := sort.SearchInts(times, startTime)
	idxHigh := sort.SearchInts(times, endTime+1)

	// Iterate over the relevant tweets and increment the count for their respective buckets.
	for i := idxLow; i < idxHigh; i++ {
		tweetTime := times[i]
		// Calculate the bucket index for the current tweet.
		// A tweet `tweetTime` falls into the bucket starting at `(tweetTime / interval) * interval`.
		// The index relative to `firstBucketStart` is `((tweetTime / interval) * interval - firstBucketStart) / interval`.
		// This simplifies to `(tweetTime / interval) - (firstBucketStart / interval)`.
		bucketIndex := (tweetTime / interval) - (firstBucketStart / interval)
		if bucketIndex >= 0 && bucketIndex < numBuckets {
			res[bucketIndex]++
		}
	}

	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}