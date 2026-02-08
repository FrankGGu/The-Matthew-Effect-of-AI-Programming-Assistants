var maxDepthAfterSplit = function(seq) {
    let ans = [];
    let depth = 0;

    for (let i = 0; i < seq.length; i++) {
        if (seq[i] === '(') {
            ans.push(depth % 2);
            depth++;
        } else { // seq[i] === ')'
            depth--;
            ans.push(depth % 2);
        }
    }

    return ans;
};