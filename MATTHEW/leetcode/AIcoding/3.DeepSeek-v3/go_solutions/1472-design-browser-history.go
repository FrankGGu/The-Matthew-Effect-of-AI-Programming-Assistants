type BrowserHistory struct {
    history []string
    current int
    last int
}

func Constructor(homepage string) BrowserHistory {
    return BrowserHistory{
        history: []string{homepage},
        current: 0,
        last: 0,
    }
}

func (this *BrowserHistory) Visit(url string) {
    this.current++
    if this.current < len(this.history) {
        this.history[this.current] = url
    } else {
        this.history = append(this.history, url)
    }
    this.last = this.current
}

func (this *BrowserHistory) Back(steps int) string {
    this.current = max(this.current-steps, 0)
    return this.history[this.current]
}

func (this *BrowserHistory) Forward(steps int) string {
    this.current = min(this.current+steps, this.last)
    return this.history[this.current]
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

/**
 * Your BrowserHistory object will be instantiated and called as such:
 * obj := Constructor(homepage);
 * obj.Visit(url);
 * param_2 := obj.Back(steps);
 * param_3 := obj.Forward(steps);
 */