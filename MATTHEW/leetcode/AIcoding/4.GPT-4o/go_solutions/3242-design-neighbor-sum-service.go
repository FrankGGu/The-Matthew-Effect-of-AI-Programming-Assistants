type NeighborSumService struct {
    nums []int
}

func Constructor(nums []int) NeighborSumService {
    return NeighborSumService{nums: nums}
}

func (nss *NeighborSumService) Update(index int, val int) {
    nss.nums[index] = val
}

func (nss *NeighborSumService) Sum(index int) int {
    sum := nss.nums[index]
    if index > 0 {
        sum += nss.nums[index-1]
    }
    if index < len(nss.nums)-1 {
        sum += nss.nums[index+1]
    }
    return sum
}