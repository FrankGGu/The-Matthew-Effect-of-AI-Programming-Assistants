function braceExpansionII(s) {
    const result = [];
    const stack = [];
    let current = [];

    function expand(parts) {
        if (parts.length === 0) return [''];
        const [first, ...rest] = parts;
        const restExpanded = expand(rest);
        const firstExpanded = first.includes('{') ? expandBrace(first) : [first];
        const res = [];
        for (const f of firstExpanded) {
            for (const r of restExpanded) {
                res.push(f + r);
            }
        }
        return res;
    }

    function expandBrace(s) {
        const parts = [];
        let i = 0;
        while (i < s.length) {
            if (s[i] === '{') {
                let j = i + 1;
                let depth = 1;
                while (j < s.length && depth > 0) {
                    if (s[j] === '{') depth++;
                    else if (s[j] === '}') depth--;
                    j++;
                }
                parts.push(s.substring(i + 1, j - 1));
                i = j;
            } else {
                parts.push(s[i]);
                i++;
            }
        }
        return expand(parts);
    }

    function parse(s) {
        let i = 0;
        while (i < s.length) {
            if (s[i] === '{') {
                let j = i + 1;
                let depth = 1;
                while (j < s.length && depth > 0) {
                    if (s[j] === '{') depth++;
                    else if (s[j] === '}') depth--;
                    j++;
                }
                const sub = s.substring(i + 1, j - 1);
                const expanded = expandBrace(sub);
                const temp = [];
                while (stack.length > 0 && stack[stack.length - 1] !== '(') {
                    temp.push(stack.pop());
                }
                stack.pop(); // remove '('
                const combined = [];
                if (temp.length === 0) {
                    for (const e of expanded) {
                        combined.push(e);
                    }
                } else {
                    for (const t of temp.reverse()) {
                        const tExpanded = t.includes('{') ? expandBrace(t) : [t];
                        for (const te of tExpanded) {
                            for (const e of expanded) {
                                combined.push(te + e);
                            }
                        }
                    }
                }
                stack.push(...combined);
                i = j;
            } else if (s[i] === '(') {
                stack.push('(');
                i++;
            } else if (s[i] === ')') {
                const temp = [];
                while (stack.length > 0 && stack[stack.length - 1] !== '(') {
                    temp.push(stack.pop());
                }
                stack.pop(); // remove '('
                const combined = [];
                if (temp.length === 0) {
                    combined.push('');
                } else {
                    for (const t of temp.reverse()) {
                        const tExpanded = t.includes('{') ? expandBrace(t) : [t];
                        for (const te of tExpanded) {
                            combined.push(te);
                        }
                    }
                }
                stack.push(...combined);
                i++;
            } else {
                stack.push(s[i]);
                i++;
            }
        }
    }

    parse(s);
    const finalResult = stack.map(item => item).sort();
    return finalResult;
}