var evaluate = function(s, knowledge) {
    const map = new Map(knowledge);
    let result = [];
    let i = 0;
    const n = s.length;

    while (i < n) {
        if (s[i] === '(') {
            let j = i + 1;
            let key = '';
            while (j < n && s[j] !== ')') {
                key += s[j];
                j++;
            }
            result.push(map.has(key) ? map.get(key) : '?');
            i = j + 1;
        } else {
            result.push(s[i]);
            i++;
        }
    }

    return result.join('');
};