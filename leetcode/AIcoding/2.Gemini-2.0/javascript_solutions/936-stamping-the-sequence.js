var movesToStamp = function(stamp, target) {
    const m = stamp.length;
    const n = target.length;
    const stamped = new Array(n).fill(false);
    const result = [];
    let count = 0;

    while (count < n) {
        let stampedThisRound = false;
        for (let i = 0; i <= n - m; i++) {
            if (!stamped[i]) {
                let canStamp = true;
                let stampedNow = false;
                for (let j = 0; j < m; j++) {
                    if (target[i + j] !== stamp[j] && target[i + j] !== '?') {
                        canStamp = false;
                        break;
                    }
                    if (target[i + j] === stamp[j]) {
                        stampedNow = true;
                    }
                }

                if (canStamp && stampedNow) {
                    result.push(i);
                    stampedThisRound = true;
                    for (let j = 0; j < m; j++) {
                        if (target[i + j] !== '?') {
                            target = target.substring(0, i + j) + '?' + target.substring(i + j + 1);
                            count++;
                        }
                    }
                    stamped[i] = true;
                }
            }
        }
        if (!stampedThisRound) {
            return [];
        }
    }

    return result.reverse();
};