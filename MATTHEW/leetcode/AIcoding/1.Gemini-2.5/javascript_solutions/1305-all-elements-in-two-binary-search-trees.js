var getAllElements = function(root1, root2) {
    const list1 = [];
    const list2 = [];

    function inorder(node, arr) {
        if (!node) {
            return;
        }
        inorder(node.left, arr);
        arr.push(node.val);
        inorder(node.right, arr);
    }

    inorder(root1, list1);
    inorder(root2, list2);

    const result = [];
    let p1 = 0;
    let p2 = 0;

    while (p1 < list1.length && p2 < list2.length) {
        if (list1[p1] <= list2[p2]) {
            result.push(list1[p1]);
            p1++;
        } else {
            result.push(list2[p2]);
            p2++;
        }
    }

    while (p1 < list1.length) {
        result.push(list1[p1]);
        p1++;
    }

    while (p2 < list2.length) {
        result.push(list2[p2]);
        p2++;
    }

    return result;
};