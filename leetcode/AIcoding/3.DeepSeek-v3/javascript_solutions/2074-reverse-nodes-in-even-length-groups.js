var reverseEvenLengthGroups = function(head) {
    if (!head || !head.next) return head;

    let current = head;
    let groupLength = 1;

    while (current) {
        let count = 0;
        let start = current;
        let prev = null;

        while (current && count < groupLength) {
            prev = current;
            current = current.next;
            count++;
        }

        if (count % 2 === 0) {
            let reversed = reverseList(start, count);
            if (start === head) {
                head = reversed;
            } else {
                let temp = head;
                while (temp.next !== start) {
                    temp = temp.next;
                }
                temp.next = reversed;
            }
            start.next = current;
        }

        groupLength++;
    }

    return head;
};

function reverseList(start, length) {
    let prev = null;
    let current = start;
    let next = null;
    let count = 0;

    while (current && count < length) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
        count++;
    }

    return prev;
}