package main

type TweetCounts struct {
    data map[string][]int
}

func Constructor() TweetCounts {
    return TweetCounts{
        data: make(map[string][]int),
    }
}

func (this *TweetCounts) RecordTweet(recordType string, timestamp int) {
    this.data[recordType] = append(this.data[recordType], timestamp)
}

func (this *TweetCounts) GetTweetCountsPerFrequency(freq string, startTime int, endTime int) []int {
    var interval int
    switch freq {
    case "minute":
        interval = 60
    case "hour":
        interval = 3600
    case "day":
        interval = 86400
    }

    result := make([]int, 0)
    for startTime <= endTime {
        end := startTime + interval - 1
        if end > endTime {
            end = endTime
        }
        count := 0
        for _, t := range this.data[freq] {
            if t >= startTime && t <= end {
                count++
            }
        }
        result = append(result, count)
        startTime += interval
    }
    return result
}