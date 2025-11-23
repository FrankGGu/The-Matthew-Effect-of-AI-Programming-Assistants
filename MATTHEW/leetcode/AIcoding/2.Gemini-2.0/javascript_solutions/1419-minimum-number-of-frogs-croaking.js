var minNumberOfFrogs = function(croakOfFrogs) {
    let c = 0, r = 0, o = 0, a = 0, k = 0;
    let frogs = 0, maxFrogs = 0;

    for (let i = 0; i < croakOfFrogs.length; i++) {
        switch (croakOfFrogs[i]) {
            case 'c':
                c++;
                frogs++;
                maxFrogs = Math.max(maxFrogs, frogs);
                break;
            case 'r':
                r++;
                c--;
                break;
            case 'o':
                o++;
                r--;
                break;
            case 'a':
                a++;
                o--;
                break;
            case 'k':
                k++;
                a--;
                frogs--;
                break;
        }

        if (c < 0 || r < 0 || o < 0 || a < 0) {
            return -1;
        }
    }

    if (c === 0 && r === 0 && o === 0 && a === 0) {
        return maxFrogs;
    } else {
        return -1;
    }
};