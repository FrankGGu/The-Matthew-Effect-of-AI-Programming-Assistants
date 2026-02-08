var dynamicPassword = function(password, target) {
    return password.slice(target) + password.slice(0, target);
};