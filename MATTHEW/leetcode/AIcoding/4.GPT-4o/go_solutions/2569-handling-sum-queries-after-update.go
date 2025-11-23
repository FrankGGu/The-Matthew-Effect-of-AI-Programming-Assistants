type NumArray struct {
    nums    []int
    segment []int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    seg := make([]int, 2*n)
    for i := 0; i < n; i++ {
        seg[n+i] = nums[i]
    }
    for i := n - 1; i > 0; i-- {
        seg[i] = seg[i*2] + seg[i*2+1]
    }
    return NumArray{nums, seg}
}

func (this *NumArray) Update(index int, val int) {
    n := len(this.nums)
    this.nums[index] = val
    pos := index + n
    this.segment[pos] = val
    for pos > 1 {
        pos /= 2
        this.segment[pos] = this.segment[pos*2] + this.segment[pos*2+1]
    }
}

func (this *NumArray) SumRange(left int, right int) int {
    n := len(this.nums)
    left += n
    right += n
    sum := 0
    for left <= right {
        if left%2 == 1 {
            sum += this.segment[left]
            left++
        }
        if right%2 == 0 {
            sum += this.segment[right]
            right--
        }
        left /= 2
        right /= 2
    }
    return sum
}