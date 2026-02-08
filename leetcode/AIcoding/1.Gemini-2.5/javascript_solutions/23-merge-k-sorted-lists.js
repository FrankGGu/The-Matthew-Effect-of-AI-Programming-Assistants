var mergeKLists = function(lists) {
    if (!lists || lists.length === 0) {
        return null;
    }

    function mergeTwoLists(l1, l2) {
        if (!l1) return l2;
        if (!l2) return l1;

        let dummyHead = new ListNode(0);
        let current = dummyHead;

        while (l1 && l2) {
            if (l1.val <= l2.val) {
                current.next = l1;
                l1 = l1.next;
            } else {
                current.next = l2;
                l2 = l2.next;
            }
            current = current.next;
        }

        if (l1) {
            current.next = l1;
        } else if (l2) {
            current.next = l2;
        }

        return dummyHead.next;
    }

    function merge(lists, start, end) {
        if (start === end) {
            return lists[start];
        }
        if (start > end) {
            return null;
        }

        let mid = Math.floor((start + end) / 2);
        let l1 = merge(lists, start, mid);
        let l2 = merge(lists, mid + 1, end);
        return mergeTwoLists(l1, l2);
    }

    return merge(lists, 0, lists.length - 1);
};