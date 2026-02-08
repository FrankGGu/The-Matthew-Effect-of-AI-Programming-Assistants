var verifyPostorder = function(postorder) {
    function isValidBSTPostorder(arr, start, end) {
        if (start >= end) {
            return true;
        }

        const rootVal = arr[end];
        let k = start; 

        // Find the split point k: elements arr[start...k-1] are for the left subtree (all < rootVal)
        // elements arr[k...end-1] are for the right subtree (all > rootVal)
        while (k < end && arr[k] < rootVal) {
            k++;
        }

        // Verify that all elements in arr[k...end-1] (the potential right subtree) are indeed greater than rootVal
        let m = k;
        while (m < end && arr[m] > rootVal) {
            m++;
        }

        // If 'm' did not reach 'end', it means there was an element in the segment arr[k...end-1]
        // that was not greater than rootVal (i.e., arr[m] <= rootVal). This violates BST properties.
        if (m !== end) {
            return false;
        }

        // Recursively check the left and right subtrees
        // Left subtree: arr[start...k-1]
        // Right subtree: arr[k...end-1]
        const leftValid = isValidBSTPostorder(arr, start, k - 1);
        const rightValid = isValidBSTPostorder(arr, k, end - 1);

        return leftValid && rightValid;
    }

    return isValidBSTPostorder(postorder, 0, postorder.length - 1);
};