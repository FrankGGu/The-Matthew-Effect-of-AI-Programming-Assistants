function Node(val, left, right, next) {
    this.val = val === undefined ? 0 : val;
    this.left = left === undefined ? null : left;
    this.right = right === undefined ? null : right;
    this.next = next === undefined ? null : next;
}

var connect = function(root) {
    if (!root) return root;

    let levelStart = root;

    while (levelStart) {
        let curr = levelStart;
        let prev = null;

        while (curr) {
            if (curr.left) {
                if (prev) {
                    prev.next = curr.left;
                }
                prev = curr.left;
            }

            if (curr.right) {
                if (prev) {
                    prev.next = curr.right;
                }
                prev = curr.right;
            }

            curr = curr.next;
        }

        levelStart = levelStart.left || levelStart.right || levelStart.next;
    }

    return root;
};