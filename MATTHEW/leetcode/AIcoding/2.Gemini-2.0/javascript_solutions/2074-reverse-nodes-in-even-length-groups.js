var reverseEvenLengthGroups = function(head) {
    let groupLength = 1;
    let current = head;
    let prev = null;

    while (current) {
        let groupHead = current;
        let groupTail = null;
        let count = 0;
        let temp = current;

        while (temp && count < groupLength) {
            groupTail = temp;
            temp = temp.next;
            count++;
        }

        if (count % 2 === 0) {
            let nextGroupHead = groupTail.next;
            groupTail.next = null;

            let reversedHead = null;
            let reversedCurrent = groupHead;
            while (reversedCurrent) {
                let nextNode = reversedCurrent.next;
                reversedCurrent.next = reversedHead;
                reversedHead = reversedCurrent;
                reversedCurrent = nextNode;
            }

            if (prev) {
                prev.next = reversedHead;
            } else {
                head = reversedHead;
            }

            groupHead.next = nextGroupHead;
            prev = groupHead;
            current = nextGroupHead;
        } else {
            prev = groupTail;
            current = temp;
        }

        groupLength++;
    }

    return head;
};