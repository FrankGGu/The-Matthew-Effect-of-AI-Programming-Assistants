var nextGreaterElement = function(n) {
    n++;
    while (true) {
        let s = String(n);
        let balanced = true;
        for (let i = 0; i < s.length; i++) {
            let count = 0;
            for (let j = 0; j < s.length; j++) {
                if (s[j] === s[i]) {
                    count++;
                }
            }
            if (count !== parseInt(s[i])) {
                balanced = false;
                break;
            }
        }
        if (balanced) {
            return n;
        }
        n++;
    }
};