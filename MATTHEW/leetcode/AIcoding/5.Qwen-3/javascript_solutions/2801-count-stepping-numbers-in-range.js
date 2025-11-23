function countSteppingNumbers(s, e) {
    const result = [];
    const digits = [];

    function generate(current) {
        if (current.length > 0) {
            const num = parseInt(current.join(''), 10);
            if (num >= s && num <= e) {
                result.push(num);
            }
        }
        if (current.length === 10) return;
        for (let i = 0; i <= 9; i++) {
            if (current.length === 0) {
                if (i === 0) continue;
                current.push(i);
                generate(current);
                current.pop();
            } else {
                const last = current[current.length - 1];
                if (Math.abs(i - last) === 1) {
                    current.push(i);
                    generate(current);
                    current.pop();
                }
            }
        }
    }

    generate(digits);
    return result.length;
}