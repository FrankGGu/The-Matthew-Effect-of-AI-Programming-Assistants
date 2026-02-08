type LUPrefix struct {
	uploaded      []bool
	longestPrefix int
	n             int
}

func Constructor(n int) LUPrefix {
	return LUPrefix{
		uploaded:      make([]bool, n+1),
		longestPrefix: 0,
		n:             n,
	}
}

func (this *LUPrefix) Upload(video int) {
	this.uploaded[video] = true
	for this.longestPrefix+1 <= this.n && this.uploaded[this.longestPrefix+1] {
		this.longestPrefix++
	}
}

func (this *LUPrefix) Longest() int {
	return this.longestPrefix
}