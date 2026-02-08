type AuthenticationManager struct {
	timeToLive int
	tokens     map[string]int
}

func Constructor(timeToLive int) *AuthenticationManager {
	return &AuthenticationManager{
		timeToLive: timeToLive,
		tokens:     make(map[string]int),
	}
}

func (this *AuthenticationManager) Generate(tokenId string, currentTime int) {
	this.tokens[tokenId] = currentTime + this.timeToLive
}

func (this *AuthenticationManager) Renew(tokenId string, currentTime int) {
	if expTime, ok := this.tokens[tokenId]; ok {
		if expTime > currentTime {
			this.tokens[tokenId] = currentTime + this.timeToLive
		}
	}
}