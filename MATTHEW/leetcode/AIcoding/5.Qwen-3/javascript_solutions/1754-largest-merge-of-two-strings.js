function largestMerge(s1, s2) {
    let i = 0, j = 0;
    let merge = [];
    while (i < s1.length && j < s2.length) {
        if (s1[i] > s2[j]) {
            merge.push(s1[i]);
            i++;
        } else if (s1[i] < s2[j]) {
            merge.push(s2[j]);
            j++;
        } else {
            if (s1.slice(i) > s2.slice(j)) {
                merge.push(s1[i]);
                i++;
            } else {
                merge.push(s2[j]);
                j++;
            }
        }
    }
    while (i < s1.length) {
        merge.push(s1[i]);
        i++;
    }
    while (j < s2.length) {
        merge.push(s2[j]);
        j++;
    }
    return merge.join('');
}