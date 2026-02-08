type LUPrefix struct {
    uploaded []bool
    max      int
}

func Constructor(n int) LUPrefix {
    return LUPrefix{uploaded: make([]bool, n+1), max: 0}
}

func (this *LUPrefix) Upload(video int) {
    this.uploaded[video] = true
    for this.max+1 <= len(this.uploaded)-1 && this.uploaded[this.max+1] {
        this.max++
    }
}

func (this *LUPrefix) Longest() int {
    return this.max
}