type NumArray struct {
    tree []int
    n    int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    tree := make([]int, n*2)
    for i := n; i < 2*n; i++ {
        tree[i] = nums[i-n]
    }
    for i := n - 1; i > 0; i-- {
        tree[i] = tree[i*2] + tree[i*2+1]
    }
    return NumArray{tree: tree, n: n}
}

func (this *NumArray) Update(index int, val int) {
    index += this.n
    this.tree[index] = val
    for index > 1 {
        index /= 2
        this.tree[index] = this.tree[index*2] + this.tree[index*2+1]
    }
}

func (this *NumArray) SumRange(left int, right int) int {
    left += this.n
    right += this.n
    sum := 0
    for left <= right {
        if left%2 == 1 {
            sum += this.tree[left]
            left++
        }
        if right%2 == 0 {
            sum += this.tree[right]
            right--
        }
        left /= 2
        right /= 2
    }
    return sum
}