var suggestedProducts = function(products, searchWord) {
    products.sort();
    let res = [];
    let left = 0;
    let right = products.length - 1;

    for (let i = 1; i <= searchWord.length; i++) {
        let prefix = searchWord.substring(0, i);
        let temp = [];

        while (left <= right && !products[left].startsWith(prefix)) {
            left++;
        }

        while (left <= right && !products[right].startsWith(prefix)) {
            right--;
        }

        let count = 0;
        for (let j = left; j <= right && count < 3; j++) {
            if (products[j].startsWith(prefix)) {
                temp.push(products[j]);
                count++;
            }
        }
        res.push(temp);
    }

    return res;
};