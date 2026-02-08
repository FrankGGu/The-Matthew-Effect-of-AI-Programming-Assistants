import "math/rand"

type Solution struct {
    head *ListNode
}

func Constructor(head *ListNode) Solution {
    return Solution{head: head}
}

func (this *Solution) GetRandom() int {
    scope := 1
    chosenValue := 0
    current := this.head

    for current != nil {
        if rand.Float64() < 1.0/float64(scope) {
            chosenValue = current.Val
        }
        scope++
        current = current.Next
    }
    return chosenValue
}

/**
 * Your Solution object will be instantiated and called as such:
 * obj := Constructor(head);
 * param_1 := obj.GetRandom();
 */