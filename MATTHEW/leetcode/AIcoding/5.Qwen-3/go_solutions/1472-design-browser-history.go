package main

type BrowserHistory struct {
    history []string
    current int
}

func Constructor(homepage string) BrowserHistory {
    return BrowserHistory{
        history: []string{homepage},
        current: 0,
    }
}

func (this *BrowserHistory) Visit(url string) {
    this.history = this.history[:this.current+1]
    this.history = append(this.history, url)
    this.current = len(this.history) - 1
}

func (this *BrowserHistory) Back(steps int) string {
    if steps > this.current {
        this.current = 0
        return this.history[0]
    }
    this.current -= steps
    return this.history[this.current]
}

func (this *BrowserHistory) Forward(steps int) string {
    if steps > len(this.history)-this.current-1 {
        this.current = len(this.history) - 1
        return this.history[this.current]
    }
    this.current += steps
    return this.history[this.current]
}