var deserialize = function(s) {
    let index = 0;

    const parse = () => {
        if (s[index] === '[') {
            index++;
            const ni = new NestedInteger();
            while (s[index] !== ']') {
                ni.add(parse());
                if (s[index] === ',') {
                    index++;
                }
            }
            index++;
            return ni;
        } else {
            let numStr = '';
            while (index < s.length && (s[index] === '-' || (s[index] >= '0' && s[index] <= '9'))) {
                numStr += s[index];
                index++;
            }
            const num = parseInt(numStr, 10);
            const ni = new NestedInteger();
            ni.setInteger(num);
            return ni;
        }
    };

    return parse();
};