type TweetCounts struct {
	tweets map[string][]int
}

func Constructor() TweetCounts {
	return TweetCounts{
		tweets: make(map[string][]int),
	}
}

func (this *TweetCounts) RecordTweet(tweetName string, time int) {
	this.tweets[tweetName] = append(this.tweets[tweetName], time)
}

func (this *TweetCounts) GetTweetCountsPerFrequency(freq string, tweetName string, startTime int, endTime int) []int {
	interval := 0
	switch freq {
	case "minute":
		interval = 60
	case "hour":
		interval = 3600
	case "day":
		interval = 86400
	}

	count := make([]int, (endTime-startTime)/interval+1)
	for _, time := range this.tweets[tweetName] {
		if time >= startTime && time <= endTime {
			count[(time-startTime)/interval]++
		}
	}
	return count
}