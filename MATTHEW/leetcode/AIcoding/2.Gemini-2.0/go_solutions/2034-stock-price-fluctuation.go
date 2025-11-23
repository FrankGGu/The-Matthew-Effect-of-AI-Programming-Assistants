type StockPrice struct {
    prices map[int]int
    maxTimestamp int
    timestamps []int
}

func Constructor() StockPrice {
    return StockPrice{
        prices: make(map[int]int),
        maxTimestamp: 0,
        timestamps: make([]int, 0),
    }
}

func (this *StockPrice) Update(timestamp int, price int)  {
    this.prices[timestamp] = price
    if timestamp > this.maxTimestamp {
        this.maxTimestamp = timestamp
    }

    found := false
    for i := 0; i < len(this.timestamps); i++ {
        if this.timestamps[i] == timestamp {
            found = true
            break
        }
    }
    if !found {
         this.timestamps = append(this.timestamps, timestamp)
    }

}

func (this *StockPrice) Current() int {
    return this.prices[this.maxTimestamp]
}

func (this *StockPrice) Maximum() int {
    maxPrice := -1
    for _, price := range this.prices {
        if price > maxPrice {
            maxPrice = price
        }
    }
    return maxPrice
}

func (this *StockPrice) Minimum() int {
    minPrice := 1000000000
    for _, price := range this.prices {
        if price < minPrice {
            minPrice = price
        }
    }
    return minPrice
}