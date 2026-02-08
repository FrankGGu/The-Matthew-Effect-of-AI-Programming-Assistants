var verifyPostorder = function(postorder) {
    const helper = (start, end) => {
        if (start >= end) return true;
        let root = postorder[end];
        let rightStart = start;

        while (rightStart < end && postorder[rightStart] < root) {
            rightStart++;
        }

        for (let i = rightStart; i < end; i++) {
            if (postorder[i] < root) return false;
        }

        return helper(start, rightStart - 1) && helper(rightStart, end - 1);
    };

    return helper(0, postorder.length - 1);
};