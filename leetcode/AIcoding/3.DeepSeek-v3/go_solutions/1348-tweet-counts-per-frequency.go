type TweetCounts struct {
    tweets map[string][]int
}

func Constructor() TweetCounts {
    return TweetCounts{tweets: make(map[string][]int)}
}

func (this *TweetCounts) RecordTweet(tweetName string, time int) {
    this.tweets[tweetName] = append(this.tweets[tweetName], time)
}

func (this *TweetCounts) GetTweetCountsPerFrequency(freq string, tweetName string, startTime int, endTime int) []int {
    var delta int
    switch freq {
    case "minute":
        delta = 60
    case "hour":
        delta = 3600
    case "day":
        delta = 86400
    }

    intervals := (endTime - startTime) / delta + 1
    res := make([]int, intervals)

    times, exists := this.tweets[tweetName]
    if !exists {
        return res
    }

    for _, t := range times {
        if t >= startTime && t <= endTime {
            idx := (t - startTime) / delta
            res[idx]++
        }
    }

    return res
}