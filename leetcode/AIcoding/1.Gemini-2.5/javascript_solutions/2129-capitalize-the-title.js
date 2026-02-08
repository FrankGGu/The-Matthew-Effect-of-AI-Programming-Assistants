var capitalizeTitle = function(title) {
    return title.split(' ').map(word => {
        if (word.length <= 2) {
            return word.toLowerCase();
        } else {
            return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
        }
    }).join(' ');
};