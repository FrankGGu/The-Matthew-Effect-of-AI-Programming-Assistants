function judgePoint24(nums) {
    const dfs = (cards) => {
        if (cards.length === 1) return Math.abs(cards[0] - 24) < 1e-6;
        for (let i = 0; i < cards.length; i++) {
            for (let j = 0; j < cards.length; j++) {
                if (i !== j) {
                    const next = [];
                    for (let k = 0; k < cards.length; k++) {
                        if (k !== i && k !== j) next.push(cards[k]);
                    }
                    if (dfs([...next, cards[i] + cards[j]])) return true;
                    if (dfs([...next, cards[i] - cards[j]])) return true;
                    if (dfs([...next, cards[j] - cards[i]])) return true;
                    if (dfs([...next, cards[i] * cards[j]])) return true;
                    if (cards[j] !== 0 && dfs([...next, cards[i] / cards[j]])) return true;
                    if (cards[i] !== 0 && dfs([...next, cards[j] / cards[i]])) return true;
                }
            }
        }
        return false;
    };
    return dfs(nums);
}