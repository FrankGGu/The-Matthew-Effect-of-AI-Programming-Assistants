var shortestCommonSuperstring = function(a, b, c) {
    function overlap(s1, s2) {
        let n1 = s1.length;
        let n2 = s2.length;
        for (let len = Math.min(n1, n2); len > 0; len--) {
            if (s1.substring(n1 - len) === s2.substring(0, len)) {
                return len;
            }
        }
        return 0;
    }

    function merge(s1, s2) {
        let len = overlap(s1, s2);
        return s1 + s2.substring(len);
    }

    function solve(s1, s2, s3) {
        let merged12 = merge(s1, s2);
        let merged21 = merge(s2, s1);
        let res1 = merge(merged12, s3);
        let res2 = merge(s3, merged12);
        let res3 = merge(merged21, s3);
        let res4 = merge(s3, merged21);

        let ans = res1;
        if (res2.length < ans.length) ans = res2;
        if (res3.length < ans.length) ans = res3;
        if (res4.length < ans.length) ans = res4;

        return ans;
    }

    let ans = solve(a, b, c);
    let t1 = solve(a, c, b);
    let t2 = solve(b, a, c);
    let t3 = solve(b, c, a);
    let t4 = solve(c, a, b);
    let t5 = solve(c, b, a);

    if (t1.length < ans.length) ans = t1;
    if (t2.length < ans.length) ans = t2;
    if (t3.length < ans.length) ans = t3;
    if (t4.length < ans.length) ans = t4;
    if (t5.length < ans.length) ans = t5;

    return ans;
};