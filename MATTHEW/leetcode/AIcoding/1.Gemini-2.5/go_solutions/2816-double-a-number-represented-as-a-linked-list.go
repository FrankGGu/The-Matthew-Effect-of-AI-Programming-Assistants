func doubleIt(head *ListNode) *ListNode {
    // Helper recursive function to double the number represented by the linked list
    // and return any carry generated.
    var doubleAndCarry func