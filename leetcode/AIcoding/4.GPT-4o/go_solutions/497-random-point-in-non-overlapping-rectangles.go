import "math/rand"

type Solution struct {
    rectangles [][]int
    prefixSum  []int
    totalArea  int
}

func Constructor(rectangles [][]int) Solution {
    prefixSum := make([]int, len(rectangles))
    totalArea := 0

    for i, rect := range rectangles {
        area := (rect[2] - rect[0]) * (rect[3] - rect[1])
        totalArea += area
        prefixSum[i] = totalArea
    }

    return Solution{rectangles, prefixSum, totalArea}
}

func (this *Solution) Pick() []int {
    target := rand.Intn(this.totalArea)
    left, right := 0, len(this.prefixSum)-1

    for left < right {
        mid := left + (right-left)/2
        if this.prefixSum[mid] <= target {
            left = mid + 1
        } else {
            right = mid
        }
    }

    rect := this.rectangles[left]
    x := rand.Intn(rect[2]-rect[0]) + rect[0]
    y := rand.Intn(rect[3]-rect[1]) + rect[1]

    return []int{x, y}
}