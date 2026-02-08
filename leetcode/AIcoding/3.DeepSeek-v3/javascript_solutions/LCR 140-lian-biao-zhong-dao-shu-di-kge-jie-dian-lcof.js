var trainingPlan = function(head, cnt) {
    let fast = head, slow = head;
    for (let i = 0; i < cnt; i++) {
        fast = fast.next;
    }
    while (fast !== null) {
        fast = fast.next;
        slow = slow.next;
    }
    return slow;
};