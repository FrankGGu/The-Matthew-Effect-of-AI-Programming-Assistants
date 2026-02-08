type LUPrefix struct {
    uploaded []bool
    prefix   int
}

func Constructor(n int) LUPrefix {
    return LUPrefix{
        uploaded: make([]bool, n+2),
        prefix:   0,
    }
}

func (this *LUPrefix) Upload(video int) {
    this.uploaded[video] = true
    for this.prefix+1 < len(this.uploaded) && this.uploaded[this.prefix+1] {
        this.prefix++
    }
}

func (this *LUPrefix) Longest() int {
    return this.prefix
}