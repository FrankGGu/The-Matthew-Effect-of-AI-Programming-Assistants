var reverseEvenLengthGroups = function(head) {
    if (!head || !head.next) {
        return head;
    }

    let dummy = new ListNode(0);
    dummy.next = head;

    let prev = dummy;
    let curr = head;
    let groupNum = 1;

    while (curr) {
        let startOfGroup = curr;
        let endOfGroup = null;
        let nextGroupStart = null;
        let actualCount = 0;

        let temp = curr;
        for (let i = 0; i < groupNum; i++) {
            if (!temp) {
                break;
            }
            endOfGroup = temp;
            temp = temp.next;
            actualCount++;
        }
        nextGroupStart = temp;

        if (actualCount % 2 === 0) {
            // Reverse the sublist from startOfGroup to endOfGroup
            let firstNodeInGroup = startOfGroup;
            let prevInSublist = nextGroupStart;
            let currInSublist = startOfGroup;

            while (currInSublist !== nextGroupStart) {
                let nextNodeInSublist = currInSublist.next;
                currInSublist.next = prevInSublist;
                prevInSublist = currInSublist;
                currInSublist = nextNodeInSublist;
            }

            // Connect the previous segment to the new head of the reversed group
            prev.next = prevInSublist;
            // The original first node (now tail) points to the next group's start
            firstNodeInGroup.next = nextGroupStart;
            // Update prev to be the tail of the current (reversed) group
            prev = firstNodeInGroup;
        } else {
            // No reversal, just move prev to the end of the current group
            prev = endOfGroup;
        }

        curr = nextGroupStart;
        groupNum++;
    }

    return dummy.next;
};