var pyramidTransition = function(bottom, allowed) {
    const map = new Map();
    for (const s of allowed) {
        const base = s.substring(0, 2);
        const top = s[2];
        if (!map.has(base)) {
            map.set(base, []);
        }
        map.get(base).push(top);
    }

    function solve(current) {
        if (current.length === 1) {
            return true;
        }

        const next = [];
        function helper(index, build) {
            if (index === current.length - 1) {
                return solve(build.join(""));
            }

            const base = current.substring(index, index + 2);
            if (!map.has(base)) {
                return false;
            }

            const tops = map.get(base);
            for (const top of tops) {
                if (helper(index + 1, [...build, top])) {
                    return true;
                }
            }

            return false;
        }

        return helper(0, []);
    }

    return solve(bottom);
};