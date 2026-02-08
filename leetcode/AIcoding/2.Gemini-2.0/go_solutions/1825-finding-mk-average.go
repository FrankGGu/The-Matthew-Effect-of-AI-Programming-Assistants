type MKAverage struct {
    m, k int
    stream []int
    sum int
    nums []int
}

func Constructor(m int, k int) MKAverage {
    return MKAverage{
        m: m,
        k: k,
        stream: []int{},
        sum: 0,
        nums: []int{},
    }
}

func (this *MKAverage) AddElement(num int)  {
    this.stream = append(this.stream, num)
    this.nums = append(this.nums, num)
}

func (this *MKAverage) CalculateMKAverage() int {
    if len(this.stream) < this.m {
        return -1
    }

    nums := make([]int, this.m)
    copy(nums, this.stream[len(this.stream)-this.m:])

    sort(nums)

    sum := 0
    for i := this.k; i < this.m - this.k; i++ {
        sum += nums[i]
    }

    return sum / (this.m - 2*this.k)
}

func sort(arr []int) {
    n := len(arr)
    for i := 0; i < n-1; i++ {
        for j := 0; j < n-i-1; j++ {
            if arr[j] > arr[j+1] {
                arr[j], arr[j+1] = arr[j+1], arr[j]
            }
        }
    }
}