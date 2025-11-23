function shoppingOffers(price, special) {
    function dfs(basket) {
        let total = 0;
        for (let i = 0; i < price.length; i++) {
            total += basket[i] * price[i];
        }
        for (const s of special) {
            let valid = true;
            for (let i = 0; i < s.length - 1; i++) {
                if (basket[i] < s[i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                let newBasket = [...basket];
                for (let i = 0; i < s.length - 1; i++) {
                    newBasket[i] -= s[i];
                }
                total = Math.min(total, s[s.length - 1] + dfs(newBasket));
            }
        }
        return total;
    }

    return dfs(Array(price.length).fill(0));
}