type BlockTracker struct {
    blocks []int
}

func Constructor() BlockTracker {
    return BlockTracker{blocks: []int{}}
}

func (this *BlockTracker) AddBlock(pos int) {
    this.blocks = append(this.blocks, pos)
    sort.Ints(this.blocks)
}

func (this *BlockTracker) RemoveBlock(pos int) {
    idx := sort.SearchInts(this.blocks, pos)
    if idx < len(this.blocks) && this.blocks[idx] == pos {
        this.blocks = append(this.blocks[:idx], this.blocks[idx+1:]...)
    }
}

func (this *BlockTracker) Query(start int, end int) bool {
    left := sort.SearchInts(this.blocks, start)
    right := sort.SearchInts(this.blocks, end+1)
    return left < right
}