var findTheWinner = function(n, k) {
    let friends = [];
    for (let i = 1; i <= n; i++) {
        friends.push(i);
    }

    let index = 0;
    while (friends.length > 1) {
        index = (index + k - 1) % friends.length;
        friends.splice(index, 1);
    }

    return friends[0];
};