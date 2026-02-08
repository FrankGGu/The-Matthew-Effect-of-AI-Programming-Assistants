var getAllElements = function(root1, root2) {
    const list1 = [], list2 = [];
    inOrder(root1, list1);
    inOrder(root2, list2);
    return merge(list1, list2);
};

function inOrder(node, list) {
    if (!node) return;
    inOrder(node.left, list);
    list.push(node.val);
    inOrder(node.right, list);
}

function merge(list1, list2) {
    const merged = [];
    let i = 0, j = 0;
    while (i < list1.length && j < list2.length) {
        if (list1[i] < list2[j]) {
            merged.push(list1[i++]);
        } else {
            merged.push(list2[j++]);
        }
    }
    while (i < list1.length) merged.push(list1[i++]);
    while (j < list2.length) merged.push(list2[j++]);
    return merged;
}