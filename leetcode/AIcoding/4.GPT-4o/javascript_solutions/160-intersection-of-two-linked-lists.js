function getIntersectionNode(headA, headB) {
    if (!headA || !headB) return null;

    let aPointer = headA;
    let bPointer = headB;

    while (aPointer !== bPointer) {
        aPointer = aPointer ? aPointer.next : headB;
        bPointer = bPointer ? bPointer.next : headA;
    }

    return aPointer;
}