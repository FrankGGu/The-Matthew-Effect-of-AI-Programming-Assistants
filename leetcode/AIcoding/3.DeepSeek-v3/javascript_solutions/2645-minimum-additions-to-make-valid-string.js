var addMinimum = function(word) {
    let res = 0;
    let expected = 'a';
    const nextChar = {
        'a': 'b',
        'b': 'c',
        'c': 'a'
    };

    for (const ch of word) {
        while (ch !== expected) {
            res++;
            expected = nextChar[expected];
        }
        expected = nextChar[ch];
    }

    while (expected !== 'a') {
        res++;
        expected = nextChar[expected];
    }

    return res;
};