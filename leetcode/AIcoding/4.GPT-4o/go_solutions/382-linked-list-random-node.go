type ListNode struct {
    Val  int
    Next *ListNode
}

type Solution struct {
    head *ListNode
    rand *rand.Rand
}

func Constructor(head *ListNode) Solution {
    return Solution{head: head, rand: rand.New(rand.NewSource(time.Now().Unix()))}
}

func (this *Solution) GetRandom() int {
    result, current, n := 0, this.head, 1
    for current != nil {
        if this.rand.Intn(n) == 0 {
            result = current.Val
        }
        n++
        current = current.Next
    }
    return result
}