var maxDiff = function(num) {
    const s = num.toString();
    const n = s.length;
    let max = 0;
    let min = 0;

    let a = s[0];
    let maxS = s.replace(new RegExp(a, 'g'), '9');
    max = parseInt(maxS);

    let minS = "";
    if (a !== '1') {
        minS = s.replace(new RegExp(a, 'g'), '1');
        min = parseInt(minS);
    } else {
        let found = false;
        for (let i = 1; i < n; i++) {
            if (s[i] !== '0' && s[i] !== '1') {
                a = s[i];
                minS = s.replace(new RegExp(a, 'g'), '0');
                found = true;
                break;
            }
        }
        if (!found) {
            minS = s;
        }
        min = parseInt(minS);
    }

    return max - min;
};