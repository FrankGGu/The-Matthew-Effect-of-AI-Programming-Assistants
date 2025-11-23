var verifyPostorder = function(postorder) {
    const helper = (start, end) => {
        if (start >= end) return true;
        let p = start;
        while (postorder[p] < postorder[end]) p++;
        let m = p;
        while (postorder[p] > postorder[end]) p++;
        return p === end && helper(start, m - 1) && helper(m, end - 1);
    };
    return helper(0, postorder.length - 1);
};