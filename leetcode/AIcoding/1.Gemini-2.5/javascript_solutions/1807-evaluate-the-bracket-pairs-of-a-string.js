var evaluate = function(s, knowledge) {
    const knowledgeMap = new Map();
    for (const [key, value] of knowledge) {
        knowledgeMap.set(key, value);
    }

    let result = [];
    let i = 0;
    while (i < s.length) {
        if (s[i] === '(') {
            let j = i + 1;
            let key = [];
            while (j < s.length && s[j] !== ')') {
                key.push(s[j]);
                j++;
            }
            const keyStr = key.join('');
            result.push(knowledgeMap.has(keyStr) ? knowledgeMap.get(keyStr) : '?');
            i = j + 1; // Move past the closing parenthesis
        } else {
            result.push(s[i]);
            i++;
        }
    }

    return result.join('');
};