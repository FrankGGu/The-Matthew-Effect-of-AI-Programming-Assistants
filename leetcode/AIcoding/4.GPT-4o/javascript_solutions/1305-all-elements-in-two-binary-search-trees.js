function getAllElements(root1, root2) {
    const inorder = (root, arr) => {
        if (!root) return;
        inorder(root.left, arr);
        arr.push(root.val);
        inorder(root.right, arr);
    };

    const arr1 = [];
    const arr2 = [];
    inorder(root1, arr1);
    inorder(root2, arr2);

    const result = [];
    let i = 0, j = 0;

    while (i < arr1.length && j < arr2.length) {
        if (arr1[i] < arr2[j]) {
            result.push(arr1[i]);
            i++;
        } else {
            result.push(arr2[j]);
            j++;
        }
    }

    while (i < arr1.length) {
        result.push(arr1[i]);
        i++;
    }

    while (j < arr2.length) {
        result.push(arr2[j]);
        j++;
    }

    return result;
}